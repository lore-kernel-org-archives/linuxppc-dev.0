From: "Lee Rhodes" <daddy_rhodes@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel thread and NULL active_mm (MPC860)
Date: Fri, 14 May 2004 16:20:00 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY19-F12mLng8FSZDh0000bc92@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Can anyone tell me what would cause my kernel thread to have a NULL
active_mm? The thread is waking up from a down_interruptible (it's a DPC
thread) and, in doing so, it triggers the BUG_ON on line 559 of sched.c.

I'm just wondering if anyone can provide me with some theories on what might
be going wrong. The same could runs fine on an i386 Linux desktop machine.
I'm only encountering this issue when I port it to MPC860.

Thanks for any tips,
Lee


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
