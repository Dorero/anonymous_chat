import consumer from "channels/consumer"

const chatElement = document.getElementById('chat')
const chatId = chatElement.dataset.chatId
const userId = chatElement.dataset.userId
const input = document.getElementById('input-message')
const button = document.getElementById('send-message')

const enterSend = (e) => {
    console.log(e.key)
    if (e.key === 'Enter') {
        const message = input.value
        input.value = ''
        subscription.speak(message)
    }
}

const send = () => {
    const message = input.value
    input.value = ''
    subscription.speak(message)
}

button.addEventListener('click', send)



const subscription = consumer.subscriptions.create({channel: "ChatChannel", chat_id: chatId, user_id: userId}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {

        if (data.status === "end") {
            document.getElementById("input-container").classList.add("hidden");
            document.getElementById("down-container").insertAdjacentHTML('beforeend', `<p>User left chat</p>`)
            button.removeEventListener("click", send)
        }

         if (data.content) {
            const messages = document.getElementById('messages')
            let html = ""

            if (userId === data.user_id) {
                html = `
                     <div class="chat-message">
                      <div class="flex items-end justify-end">
                        <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-1 items-end">
                          <div><span class="px-4 py-2 rounded-lg inline-block rounded-br-none bg-blue-600 text-white ">${data.content}</span></div>
                        </div>
                      </div>
                    </div>
                 `
            } else {
                html = `
                   <div class="chat-message">
                      <div class="flex items-end">
                        <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-2 items-start">
                          <div><span class="px-4 py-2 rounded-lg inline-block rounded-bl-none bg-gray-300 text-gray-600">${data.content}</span></div>
                        </div>
                      </div>
                    </div>
                    `

            }
            messages.insertAdjacentHTML('beforeend', html)
        }
    },

    speak: function (message) {
        return this.perform('speak', {message: message, user_id: userId});
    },
});

