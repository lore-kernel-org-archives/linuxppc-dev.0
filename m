Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <321DD189-631A-11D8-B915-000393D57FEE@jeppesens.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-embedded@lists.linuxppc.org
From: Karsten Jeppesen <kj-list@jeppesens.com>
Subject: Simple module question
Date: Thu, 19 Feb 2004 12:28:36 -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aren't they all......


I am doing some heavy work in a write function.
But I have a poll wait loop (waiting for flash program end) where a lot
of time is wasted.
How do I tell the scheduler that I would like t surrender the CPU for
others to use?
I tried calling scheduler(), but that only crashed the kernel.
What is the correct way?

Sincerely,
Karsten


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
