Subject: Real Time response/latency question
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 30 Nov 1999 14:48:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991130034844.1B3E0F380@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

I'm looking at software architecture questions, and wondering how much
application domain work I can move out of driver land and into user space,
hence the following question: Can anyone give me a rough idea of the maximum
latency in user space I could expect on an 860T based system with multiple
threads, where only one thread has SCHED_RR realtime scheduling priority?

Thanks,
Graham

PS: If you're in Sydney Australia and you're interested in an Embedded Linux
job doing 860/855T stuff, please let me know.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
