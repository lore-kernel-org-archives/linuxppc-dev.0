Date: Thu, 13 Sep 2001 10:18:33 -0400
Message-Id: <200109131418.f8DEIXB20179@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: qiuqingjun@263.net
Cc: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <008b01c13c12$0d452e00$0200a8c0@aiwa> (qiuqingjun@263.net)
Subject: Re: In initrd, init program is needed or not?
References: <002a01c13b93$72b3c5a0$0200a8c0@aiwa> <200109121441.f8CEf1016518@hyper.wm.sps.mot.com> <008b01c13c12$0d452e00$0200a8c0@aiwa>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Hi, Peter Barada,
>Thank your explaination of init program in detail, however , I have
>another question:
>
>Where can I find the source code of the init program?
>Thank you again!

We 'borrowed' the init code from the ucLinux distribution (user/init).
I'm thinking of changing to the version that is distributed with HardHat.
I know that will be more code(hence larger footprint), but the
benifit of using an actively developing piece of code is very appealing.

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
