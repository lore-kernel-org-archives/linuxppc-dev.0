To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Dec 2001 10:07:14 EST."
             <5.1.0.14.2.20011204095651.01b2b6b8@falcon.si.com>
Date: Tue, 04 Dec 2001 16:28:16 +0100
Message-Id: <20011204152821.E36EBF9C0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.2.20011204095651.01b2b6b8@falcon.si.com>
Jerry Van Baren wrote:
>
> I've used the EST vxWorks-based BootROM (disclaimer: not the latest
> version) and it is nearly functional... if you use vxWorks, it works just
> fine.  If you warp your non-vxWorks world just right, it also works
> fine.  But there comes a point where you simply get sick of living in a
> warped world, throw away vxWorks, and load PPCBoot.  PPCBoot is MUCH easier

BTW: you can use PPCBoot and still continue to use VxWorks  as  RTOS;
PPCBoot  can  boot  more  things than just Linux - although that's is
main purpose :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It usually takes more than three weeks to prepare  a  good  impromptu
speech.                                                  - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
