Return-Path: <r.goyet@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0978CB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 07:23:43 +1100 (EST)
Received: by qwb8 with SMTP id 8so232442qwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Mar 2011 13:23:39 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 24 Mar 2011 21:23:39 +0100
Message-ID: <AANLkTikbd0S6MGK4p7=_0q8c6nbk=k1TmLcM+Mc52=FW@mail.gmail.com>
Subject: High load average (~2.0) on an idle PowerPC 64 machine
From: Romain Goyet <r.goyet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I there,

 I've this Quad G5 machine that's sitting pretty much idle with the
latest Debian stable installed, and yet it's got an abnormaly high
load average.
I've detailed the situation over here, maybe you guys will find it
interesting or have something to say :
http://serverfault.com/questions/251299/high-load-average-over-2-0-on-an-idle-machine

The machine doesn't seem to be actually slowed down, it looks more
like an incorrect measurement.

Thank you very much for any help !

 - Romain
