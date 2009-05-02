Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 541EADDF3D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 21:29:25 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1973836wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 02 May 2009 04:29:24 -0700 (PDT)
Date: Sat, 2 May 2009 07:29:16 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] windfarm: Convert to a new-style i2c drivers
Message-ID: <20090502112916.GA17797@hansolo.jdub.homelinux.org>
References: <20090416185615.2f7914ca@hyperion.delvare>
	<18939.54528.381551.291247@cargo.ozlabs.ibm.com>
	<20090502094909.3b70b216@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090502094909.3b70b216@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 02, 2009 at 09:49:09AM +0200, Jean Delvare wrote:
>On Sat, 2 May 2009 15:07:12 +1000, Paul Mackerras wrote:
>> Jean Delvare writes:
>> 
>> > The legacy i2c binding model is going away soon, so convert the
>> > macintosh windfarm drivers to the new model or they will break.
>> 
>> All works OK on my quad G5 (PowerMac11,2).
>> 
>> Tested-by: Paul Mackerras <paulus@samba.org>
>
>Great, thanks for the test results Paul! Only therm_windtunnel still
>needs to be tested.

I got my G4 installed yesterday.  Will get a new kernel built for it over
the weekend and let you know.

josh
