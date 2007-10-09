Return-Path: <ivica.babarovic@asist.si>
Received: from mx1.telemach.net (mx1.telemach.net [213.143.65.10])
	by ozlabs.org (Postfix) with ESMTP id E7AF0DDF4E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Oct 2007 17:23:15 +1000 (EST)
Received: from linux.asist (tm.213.143.88.152.dc.telemach.net [213.143.88.152])
	by mx1.telemach.net (Postfix) with ESMTP id 5C3516629A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Oct 2007 09:22:58 +0200 (CEST)
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id 9053771C312
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Oct 2007 09:23:12 +0200 (CEST)
Message-ID: <470B2C60.9010906@asist.si>
Date: Tue, 09 Oct 2007 09:23:12 +0200
From: Babarovic Ivica <ivica.babarovic@asist.si>
MIME-Version: 1.0
To: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Detecting power cycle on lite5200
References: <470B2142.8080106@asist.si>
In-Reply-To: <470B2142.8080106@asist.si>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ehh ... we found a register called CDM Bread Crumb Register.
We'll use it since it's not reset.

Babarovic Ivica wrote:
> Hi!
>
> I was wondering if there is a way to detect power cycle
> on lite5200 board. I need this information for statistics and
> some other stuff.
> I need to know when the device was powered down and
> somehow read/get this information on bootup.
>
> Best regards
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>   
