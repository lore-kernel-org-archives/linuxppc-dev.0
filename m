Return-Path: <medp@primagraphics.co.uk>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 179202BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 20:24:55 +1100 (EST)
Message-ID: <41E63CD1.901@primagraphics.co.uk>
Date: Thu, 13 Jan 2005 09:18:09 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: Aubrey Lee <aubrey1127@gmail.com>
References: <7f834d4e0501130050666b757a@mail.gmail.com>
In-Reply-To: <7f834d4e0501130050666b757a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: About Zebra Error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Aubrey Lee wrote:

> hi, In the PC(i686) system, I build and run zebra successfully. And now
>I'm porting it to the powerpc system. Cross-compiling finished without error.
>But when I run the zebra from my target board, it gives me  a big headache:
>--------------------------------------------------------------------------  
>bash-2.05b# /opt/zebra/sbin/zebra
>             sock: Address family not supported by protocol
>----------------------------------------------------------------------------
>And Up to now I cann't find the message in the souce 
>code files.  
>     The two ethx and their driver of my board is OK.
>     What shall I do?
>  
>
I had a similar message when running udhcpd. The problem was that some 
network drivers were built as modules. Adding the following to 
modules.conf cured my problem:

    # PF_PACKET support needed by udhcpc
    alias net-pf-17 af_packet

-- 
Mark Powell, Senior Software Engineer
Curtiss-Wright Controls Embedded Computing
Tel: +44 (0) 1763 852222
Email: medp@primagraphics.com
