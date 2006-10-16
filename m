Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0EBA367D7A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 05:20:37 +1000 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Not know how to build image and user application from ELDK 4.0 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Oct 2006 00:21:37 +1000."
	<20061016142137.34580.qmail@web33007.mail.mud.yahoo.com>
Date: Mon, 16 Oct 2006 21:20:34 +0200
Sender: wd@denx.de
Message-Id: <20061016192034.8EADD353C62@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061016142137.34580.qmail@web33007.mail.mud.yahoo.com> you wrote:
>
> I have just installed ELDK 4.0 for TQM 8xxL and read it README but I don't know how to build my custom image or adding user application.Such as I want to build ssh and openssh but I don't know where to start and how to do it step by step.
> Every one who HAD did it please  guide me step by step to do it

I strongly recommend to read the extensive documentation that is
available at http://www.denx.de/wiki/view/DULG/Manual?stickboard=tqm8xxl

Also, I would like to point out that you should use  ELDK  3.1.1  for
MPC8xx  based  systems  like  the  TQM8xxL (that's the reason why the
TQM8xxL ships with ELDK 3.1.1 included on CDROM).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A Perl script is correct if it's halfway readable and  gets  the  job
done before your boss fires you.
                       - L. Wall & R. L. Schwartz, _Programming Perl_
