Return-Path: <meador_inge@mentor.com>
Message-ID: <4DE53F57.2050402@mentor.com>
Date: Tue, 31 May 2011 14:19:51 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc: document the FSL MPIC message register
	binding
References: <1305909399-26969-1-git-send-email-meador_inge@mentor.com>	<1305909399-26969-2-git-send-email-meador_inge@mentor.com>
	<20110526150643.3e01f9a6@schlenkerla.am.freescale.net>
In-Reply-To: <20110526150643.3e01f9a6@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/26/2011 03:06 PM, Scott Wood wrote:
>> > +    - interrupts: Specifies a list of interrupt source and level-sense pairs.
>> > +      The type shall be <prop-encoded-array>.  The length shall be equal to
>> > +      the number of bits set in the 'msg-receive-mask' property value.
> Oh, just noticed -- mismatch between msg-receive-mask here...
> 
>> > +
>> > +Optional properties:
>> > +
>> > +    - mpic-msgr-receive-mask: Specifies what registers in the containing block
>> > +      are allowed to receive interrupts.  The value is a bit mask where a set
>> > +      bit at bit 'n' indicates that message register 'n' can receive interrupts.
>> > +      The type shall be <prop-encoded-array>.  If not present, then all of
>> > +      the message registers in the block are available.
> ...and mpic-msgr-receive-mask here.
> 
> Might want to just say "equal to the number of registers that are
> available for receiving interrupts", to more clearly apply to the case where
> mpic-msgr-receive-mask is missing.
> 

Thanks; fixed.

-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
