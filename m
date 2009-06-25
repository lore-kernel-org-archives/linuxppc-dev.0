Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B5557B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 04:38:16 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id E8D46DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 04:38:14 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so233940fga.16
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 11:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <abe8a1fd0906251136t36d78428k90a610fdff987ab6@mail.gmail.com>
References: <abe8a1fd0906251136t36d78428k90a610fdff987ab6@mail.gmail.com>
Date: Fri, 26 Jun 2009 00:08:12 +0530
Message-ID: <abe8a1fd0906251138g53ef9253j64a537f6dfa18286@mail.gmail.com>
Subject: Slowing down the schedular, How?
From: kernel mailz <kernelmailz@googlemail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a SMP linux running on 85xx poweprc. Say on Core 0 and Core 1
two different processes are running and on both the schedular runs.
Now for some special case, if one of my process issues a ioctl which
gets serviced by a kernel module, I wish to slow the schedular on that
core only. Otherwise the performance will get degraded.

Should I use highest priority tasklet, will it be sufficient or i need
to do something special

-TZ
