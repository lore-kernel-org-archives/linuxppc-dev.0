Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-06.bluehost.com (outbound-mail-06.bluehost.com
	[67.138.240.206]) by ozlabs.org (Postfix) with SMTP id EC6146894E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Dec 2005 04:25:04 +1100 (EST)
Message-ID: <43B2C8D5.3040509@secretlab.ca>
Date: Wed, 28 Dec 2005 10:18:13 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
References: <43B25117.8060008@secretlab.ca>
	<17330.32574.594398.522752@cargo.ozlabs.ibm.com>
In-Reply-To: <17330.32574.594398.522752@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PReP fails to boot on QEMU (current git snapshot)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Grant Likely writes:
> 
> 
>>zImage.prep built from head of Linus' tree fails to boot with the error
>>below.
> 
> 
> Did you do a parallel make (make -jN)?  There is a problem currently

Nope, no flags to make whatsoever

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
