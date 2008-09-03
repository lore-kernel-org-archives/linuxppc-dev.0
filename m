Return-Path: <dgibson@ozlabs.org>
Date: Wed, 3 Sep 2008 10:25:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DTS question
Message-ID: <20080903002534.GD9681@yookeroo.seuss>
References: <48BDB68E.8040806@mlbassoc.com>
	<20080902234207.GB9681@yookeroo.seuss>
	<48BDD6EE.40600@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48BDD6EE.40600@mlbassoc.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 06:14:38PM -0600, Gary Thomas wrote:
> David Gibson wrote:
>> On Tue, Sep 02, 2008 at 03:56:30PM -0600, Gary Thomas wrote:
>   <snip>
>>> What gives?  Why is explicit hex sometimes an error and sometimes not?
>>
>> Because we changed the format at one point.  Originally (the "dts-v0"
>> format) it was implicitly hex everywhere, which turned out to be a
>> mistake.  So we introduced the new dts-v1 format which uses C-style
>> literals.  New-style files are marked with a /dts-v1/; token at the
>> top of the file.
>
> Gotcha, thanks.  Not sure where I picked up the dts-v0 file I based
> my platform on, but at least now I understand the magic.

Well, it's only fairly recently that we converted all the in-kernel
files to v1, so you may have grabbed something before the conversion.

We're hoping to get everyone converted over to v1 as quickly as
possible, to avoid this sort of confusion.

>>> Is the format of this file documented anywhere (I've not found it)?
>>
>> It's in Documentation/dts-format.txt in the dtc tree.  I don't think
>> that's been included in the version of dtc in the kernel tree, though,
>> so you'll need to download the standalone dtc.
>>
>
> Where do I find this "dtc" tree?

git://git.jdl.com/software/dtc.git

Or get tarballs from

http://jdl.com/software/

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
