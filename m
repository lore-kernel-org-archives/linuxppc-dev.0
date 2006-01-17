Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-08.bluehost.com (outbound-mail-08.bluehost.com
	[67.138.240.208]) by ozlabs.org (Postfix) with SMTP id 75464689C4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 07:19:27 +1100 (EST)
Message-ID: <43CD5144.1070401@secretlab.ca>
Date: Tue, 17 Jan 2006 13:19:16 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: T Ziomek <ctz001@email.mot.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <mailman.134.1137523561.17753.linuxppc-embedded@ozlabs.org>
	<Pine.WNT.4.61.0601171341520.2664@holyoke.labs.mot.com>
In-Reply-To: <Pine.WNT.4.61.0601171341520.2664@holyoke.labs.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

T Ziomek wrote:
> Here's another lurker poking his head up...
> 
> Grant Likely wrote:
> 
>>John Bonesio wrote:
>>
>>>Hello,
>>>
>>>I work in the Xilinx software group.
>>>
>>>I'm replying to this email thread because Grant suggested there be a GIT
>>>tree for Virtex specific changes.
>>
>>I was told today that we may be able to use Paul's linuxppc tree.  I'm
>>going to ask him later today.
> 
> 
> Probably a newbie question...my understanding is that kernel.org is the
> preferred repository for PPC-specific code these days, correct?  So the a-
> bove is referring to Xilinx-specific PPC code?  From what I can see on LXR
> and kernel.org neither has any Xilinx-related code...

mainline linux-2.6 tree has ml300 support

ml300 platform bus support is pending for the powerpc.git tree
ml403 support is pending for the powerpc.git tree

powerpc.git is periodically pulled into linux-2.6

both are on kernel.org

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
