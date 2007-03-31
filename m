Return-Path: <bgat@billgatliff.com>
Received: from smtp2.mtco.com (smtp2.mtco.com [207.179.226.205])
	by ozlabs.org (Postfix) with ESMTP id 03517DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Mar 2007 14:15:21 +1000 (EST)
Message-ID: <460DDB1F.7020106@billgatliff.com>
Date: Fri, 30 Mar 2007 22:53:03 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: PPC login puzzle
References: <20070329192932.98FBD353A6C@atlas.denx.de>	<200703291345.35978.tmaenner@aehr.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Charles:

Charles Krinke wrote:
> I have 2 targets, both kernel.org linux-2.6.17.11. Both are currently using rootfile systems from montavista's 2.6.10 distribution. One is a PPC8241 and the other is a PPC8541.
>  
> On the 8241, I can login with a telnet session as root. On the 8541, I cannot. On both, I can login at the serial terminal as root with no passwd.
>  
> Neither as a password for root in /etc/passwd. That is, the first line in the passwd file says "root::0:0:root:/root/bin/bash".
>  
> Being toasters, I dont want a password to cook my toast.
>  
> The question is:
>  
> "What are the various things that might cause one toaster to be able to login from a telnet session and another, very similar one to not be able to do this?"
>   


Are their /etc/securetty files identical?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
