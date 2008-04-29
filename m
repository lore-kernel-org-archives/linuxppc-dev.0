Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 6D7E6DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 22:09:07 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so58851anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:09:06 -0700 (PDT)
Message-ID: <fa686aa40804290508y16c0ae6eq967d2c0d1911b4db@mail.gmail.com>
Date: Tue, 29 Apr 2008 06:08:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: build failure on efika
In-Reply-To: <18454.49097.53537.474679@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18454.49097.53537.474679@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 12:27 AM, Paul Mackerras <paulus@samba.org> wrote:
> My test builds for efika currently fail with this message:
>
>  FATAL: drivers/serial/mpc52xx_uart: struct of_device_id is not terminated with a NULL entry!
>  make[2]: *** [__modpost] Error 1
>  make[1]: *** [modules] Error 2
>  make: *** [sub-make] Error 2
>
>  Could you do a little patch to add the NULL entry please?

Will do.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
