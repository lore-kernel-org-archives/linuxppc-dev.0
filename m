Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110126194301.GA13541@zod.rchland.ibm.com>
References: <1296062434-18027-1-git-send-email-grant.likely@secretlab.ca>
	<20110126194301.GA13541@zod.rchland.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 26 Jan 2011 12:58:50 -0700
Message-ID: <AANLkTimmHSxP32WsYL1ZXor1GuZQ6W91gcbmKOyQumK_@mail.gmail.com>
Subject: Re: [PATCH] dt: Move device tree documentation out of powerpc
	directory
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 26, 2011 at 12:43 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> w=
rote:
> On Wed, Jan 26, 2011 at 10:20:34AM -0700, Grant Likely wrote:
>>The device tree is used by more than just PowerPC. =A0Make the documentat=
ion
>>directory available to all.
>>
>>Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>---
>>
>>Assuming nobody has an issue with this, I'll push it out to Linus for
>>2.6.38 since it is only a documentation change.
>>
>>g.
>>
>> .../bindings}/4xx/cpm.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A00
>> .../bindings}/4xx/emac.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A00
>> .../bindings}/4xx/ndfc.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A00
>> .../bindings}/4xx/ppc440spe-adma.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A00
>> .../bindings}/4xx/reboot.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A00
>
> This should probably be renamed to ...bindings}/powerpc4xx/ in that
> case. =A0Similarly for fsl (even more so since they have ARM parts too).

okay, I'll look at reorganizing.

>
> Also the booting-without-of.txt file is very powerpc specific. =A0So I
> would suggest either creating a powerpc/ directory under /bindings or
> something similar.

Actually, it isn't.  Very little of it is powerpc-specific, and after
I looked at it I decided that it still made sense to keep it in this
file and add additional sections for arm, x86, mips and microblaze
entry.

g.
