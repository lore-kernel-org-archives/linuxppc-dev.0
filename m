Mime-Version: 1.0
Message-Id: <v04220803b5d51a99c774@[10.0.0.42]>
In-Reply-To: <20000831184447.D3823@opus.bloom.county>
References: <39AE80BD.D86B34DA@embeddededge.com>
 <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es>
 <20000831184447.D3823@opus.bloom.county>
Date: Fri, 1 Sep 2000 01:42:14 -0700
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:44 PM -0700 8/31/00, Tom Rini wrote:
>On Thu, Aug 31, 2000 at 06:10:55PM +0200, Gabriel Paubert wrote:
>>
>>
>>  On Thu, 31 Aug 2000, Dan Malek wrote:
>>
>>  > I would also like to see us spend a little more time trying to
>>  > stabilize 2.4 instead of trying to solve elaborate configuration and
>>  > boot schemes.  That is what 2.5 is for.
>>
>>  What are your problems with 2.4 ? I'm at 2.4.0-test7 and I've not had any
>>  problem so far, although I still need to upgrade my modutils.
>
>Here's a few: The PCI resource allocation/conflict stuff has "issues" with
>some Pmacs (7600, Yikes! G4, I don't know about others).

B&W G3 as well (same thing as the Yikes! G4 really).  I have the
following problems on one (latest BK 2.4.0-test8 kernel, as of a
couple minutes ago):

1. Resource conflicts are reported for the CMD646 IDE controller and
an Adaptec 2940UW card

2. During the fb probe of the Rage 128 PCI card, a pattern of colored
characters is written to the screen.  This might be somebody's
deliberate debug output, as it almost looks too regular to be an
error.

3. When attempting to do the partition scan, the kernel has massive
problems with lost IDE interrupts and failed DMA stuff.  Eventually
it gives up and moves on without successfully scanning my IDE drive.

4. Probably due to the resource conflict problem, the aic7xxx driver
doesn't recognize the 2940.  This is a showstopper for me because my
root partition's on a drive connected to the 2940.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
