Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-21.bluehost.com (outbound-mail-21.bluehost.com
	[70.103.189.16]) by ozlabs.org (Postfix) with SMTP id 96DDF689C4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 07:37:28 +1100 (EST)
Message-ID: <43CD557C.6050308@secretlab.ca>
Date: Tue, 17 Jan 2006 13:37:16 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: T Ziomek <ctz001@email.mot.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <mailman.134.1137523561.17753.linuxppc-embedded@ozlabs.org>
	<Pine.WNT.4.61.0601171341520.2664@holyoke.labs.mot.com>
	<43CD5144.1070401@secretlab.ca>
	<Pine.WNT.4.61.0601171420460.2664@holyoke.labs.mot.com>
In-Reply-To: <Pine.WNT.4.61.0601171420460.2664@holyoke.labs.mot.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: T Ziomek <Tom.Ziomek@motorola.com>, linuxppc-embedded@ozlabs.org
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
> On Tue, 17 Jan 2006, Grant Likely wrote:
>> T Ziomek wrote:
>>> Grant Likely wrote:
>>>> John Bonesio wrote:
>>>>> Grant Likely wrote:
>>>>> I'm replying to this email thread because Grant suggested there be 
>>>>> a GIT
>>>>> tree for Virtex specific changes.
<--- snip --->
>>
>> mainline linux-2.6 tree has ml300 support
>>
>> ml300 platform bus support is pending for the powerpc.git tree
>> ml403 support is pending for the powerpc.git tree
>>
>> powerpc.git is periodically pulled into linux-2.6
>>
>> both are on kernel.org
> 
> Meh, okay.  But then what are the "Virtex specific changes" that would need
> to be in Paul's linuxppc tree or anywhere but kernel.org?

Basically, I was thinking about a 'development sandbox' that feeds into 
linux-2.6.git.  However, if we can use Paul's powerpc tree, then I don't 
need to create yet-another-git-tree

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
