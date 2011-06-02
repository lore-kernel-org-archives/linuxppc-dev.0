Return-Path: <meador_inge@mentor.com>
Message-ID: <4DE79F3A.9010805@mentor.com>
Date: Thu, 02 Jun 2011 09:33:30 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/2] powerpc: document the FSL MPIC message register
	binding
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>	<1306869543-18812-2-git-send-email-meador_inge@mentor.com>
	<20110531142352.2c272483@schlenkerla.am.freescale.net>
In-Reply-To: <20110531142352.2c272483@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2011 02:23 PM, Scott Wood wrote:

> On Tue, 31 May 2011 14:19:02 -0500
> Meador Inge <meador_inge@mentor.com> wrote:
> 
>> This binding documents how the message register blocks found in some FSL
>> MPIC implementations shall be represented in a device tree.
>>
>> Signed-off-by: Meador Inge <meador_inge@mentor.com>
>> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Scott Wood <scottwood@freescale.com>
>> ---
>>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 ++++++++++++++++++++
>>  1 files changed, 62 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> 
> ACK

Thanks.  Any comments on the implementation side:
http://patchwork.ozlabs.org/patch/98075/ ?

-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
