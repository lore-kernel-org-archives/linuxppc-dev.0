To: =?gb2312?q?ZhongJun=20Zhou?= <zjzhou@newrocktech.com>
Cc: Peter Barada <pbarada@mail.wm.sps.mot.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel memory mapping problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 07 Aug 2003 23:49:23 +0800."
             <20030807154923.56073.qmail@web105.mail.yahoo.com>
Date: Thu, 07 Aug 2003 23:32:23 +0200
Message-Id: <20030807213228.A9194C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030807154923.56073.qmail@web105.mail.yahoo.com> you wrote:
>
> But my functions are serial running on PPC82xx, its
> means that when I mapped the the address using __pa(
> (void *)tmp) to bd_address, then reading the BD's
> status and control registers, if OK, then return from

Just a stupid question: what are the alignment requirements of a  BD,
and which alignment is guaranteed for your tmp buffer?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
This cultural mystique surrounding the  biological  function  --  you
realize humans are overly preoccupied with the subject.
	-- Kelinda the Kelvan, "By Any Other Name", stardate 4658.9

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
