Return-Path: <gary@mlbassoc.com>
Message-ID: <48BDD6EE.40600@mlbassoc.com>
Date: Tue, 02 Sep 2008 18:14:38 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: DTS question
References: <48BDB68E.8040806@mlbassoc.com>
	<20080902234207.GB9681@yookeroo.seuss>
In-Reply-To: <20080902234207.GB9681@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Sep 02, 2008 at 03:56:30PM -0600, Gary Thomas wrote:
   <snip>
>> What gives?  Why is explicit hex sometimes an error and sometimes not?
> 
> Because we changed the format at one point.  Originally (the "dts-v0"
> format) it was implicitly hex everywhere, which turned out to be a
> mistake.  So we introduced the new dts-v1 format which uses C-style
> literals.  New-style files are marked with a /dts-v1/; token at the
> top of the file.

Gotcha, thanks.  Not sure where I picked up the dts-v0 file I based
my platform on, but at least now I understand the magic.

>> Is the format of this file documented anywhere (I've not found it)?
> 
> It's in Documentation/dts-format.txt in the dtc tree.  I don't think
> that's been included in the version of dtc in the kernel tree, though,
> so you'll need to download the standalone dtc.
> 

Where do I find this "dtc" tree?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
