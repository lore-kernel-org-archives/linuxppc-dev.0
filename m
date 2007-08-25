Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s12.bay0.hotmail.com (bay0-omc1-s12.bay0.hotmail.com
	[65.54.246.84]) by ozlabs.org (Postfix) with ESMTP id 595D1DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Aug 2007 00:46:17 +1000 (EST)
Message-ID: <BAY138-F32C3A2797C436D673EABDDB2D00@phx.gbl>
In-Reply-To: <fa686aa40708250710q72bdaa90na4974f1af6030997@mail.gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: grant.likely@secretlab.ca
Subject: Re: how to get your linux-2.6-virtex tree?
Date: Sat, 25 Aug 2007 14:46:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Grant,

>What does 'dig git.secretlab.ca' tell you?  I see this:
>;; ANSWER SECTION:
>git.secretlab.ca.       1320    IN      A       208.123.74.12

I released 'dig git.secretlab.ca' and saw this: 
;; QUESTION SECTION:
;git.secretlab.ca.              IN      A

;; ANSWER SECTION:
git.secretlab.ca.       855     IN      A       208.123.74.12




>Have you tried the git:// protocol?

Yes. I tried both git:// and http://. 

For git:// protocal:
mingliu@romeo ~ $ git-clone git://git.secretlab.ca/git/linux-2.6-virtex.git
fatal: unexpected EOF
fetch-pack from 'git://git.secretlab.ca/git/linux-2.6-virtex.git' failed.


For http:// protocal:
mingliu@romeo ~ $ git-clone 
http://git.secretlab.ca/git/linux-2.6-virtex.git
Getting alternates list for 
http://git.secretlab.ca/git/linux-2.6-virtex.git/
Getting pack list for http://git.secretlab.ca/git/linux-2.6-virtex.git/
Getting index for pack d1a6ff0f5f0433214bc37fd3038ff75f080c073d
Getting index for pack 41af2e852d9cb50ce5c8b3fe77c269780b979323
Getting index for pack a36ffcb5ecf2e87cbd9da9384dc9bd617f6169c4
Getting pack a36ffcb5ecf2e87cbd9da9384dc9bd617f6169c4
 which contains 0d62d8a8e639210cecab55f5921f293cb8250a31
walk 0d62d8a8e639210cecab55f5921f293cb8250a31
walk f9892f74b7d827a7d1b80cd418aca30f32b46c73
Getting pack d1a6ff0f5f0433214bc37fd3038ff75f080c073d
 which contains ebf9bf84da0aab5ed944264a5db2a65fe3a3e883
......

Is that the problem of my cluster? Ohmm. I need to check this now.

BR
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
