Return-Path: <bgat@billgatliff.com>
Received: from smtp1.mtco.com (smtp1.mtco.com [207.179.226.202])
	by ozlabs.org (Postfix) with ESMTP id B7F75DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 03:35:11 +1000 (EST)
Message-ID: <460E9B21.80004@billgatliff.com>
Date: Sat, 31 Mar 2007 12:32:17 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: PPC login puzzle
References: <20070329192932.98FBD353A6C@atlas.denx.de><200703291345.35978.tmaenner@aehr.com><9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com><460DDB1F.7020106@billgatliff.com><9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6C@MERCURY.inside.istor.com>	<b4b98b690703310920k63a60835s8d3ba6993d72179d@mail.gmail.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6D@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6D@MERCURY.inside.istor.com>
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

Charles Krinke wrote:
> Seems to me thing you can do is find out why the telnet session is being rejected.  Have you done an ethernet capture? 
>
> Do you have any firewalling setup?  In that case you need to make sure your rules are setup properly.  The ethernet capture should give you a clue. 
>
> Are you sure the telnetd can be found on your system that doesn't work?  What do the logs tell you on the machine that doesn't work?  I think xinetd kicks out a log file, what does that tell you?
>
> Have you tried on the 8541,  login to the terminal and then telnet to localhost?  If you can do that, then I'd say it's a firewalling problem, if not, then it's a telnetd type of problem.  
>   

Isn't there a config file that tells telnetd whether a root login is ok?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
