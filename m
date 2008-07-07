Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40807061726r1b8c876au31c8a4df81455622@mail.gmail.com>
Date: Sun, 6 Jul 2008 18:26:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>, Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] 52xx: add missing MSCAN FDT nodes for TQM52xx
In-Reply-To: <20080706235328.GB6267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486B50D8.5000009@grandegger.com>
	<20080706235328.GB6267@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 6, 2008 at 5:53 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Wed, Jul 02, 2008 at 11:56:40AM +0200, Wolfgang Grandegger wrote:
>> This patch adds the still missing FDT nodes for the MSCAN devices for
>> the TQM52xx modules.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>> arch/powerpc/boot/dts/tqm5200.dts |   16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
>>
>> Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
>> ===================================================================
>> --- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm5200.dts
>> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
>> @@ -70,6 +70,22 @@
>>                       fsl,has-wdt;
>>               };
>>
>> +             can@900 {
>> +                     compatible = "fsl,mpc5200-mscan";
>> +                     cell-index = <0>;
>
> What shared resource are these cell-index values used to index into?
> Because cell-index is so freqeuntly misunderstood, I strongly
> recommend putting a comment describing this.

This is still my fault.  The lite5200.dts which everyone uses as the
example to go by for 5200 board ports still has it, so everyone just
copies it.  I'll look at fixing all of them up.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
