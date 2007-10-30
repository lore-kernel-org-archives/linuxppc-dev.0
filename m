Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by ozlabs.org (Postfix) with ESMTP id 79BB2DE3BB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 03:19:52 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1445491nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Oct 2007 09:19:50 -0700 (PDT)
Message-ID: <fa686aa40710300919y4f231eb4w4ba4bc0c8d9260ff@mail.gmail.com>
Date: Tue, 30 Oct 2007 10:19:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: videobuf
In-Reply-To: <1193758138.4606.7.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1193758138.4606.7.camel@PisteOff>
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

On 10/30/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> I'm  working on building a v4l2 driver for an FPGA module on a Xilinx
> Virtex4 PPC.
>
> Question:
> Why does the v4l2 videobuf *depend* on PCI?

You could try dropping the dependency from Kconfig and see what breaks
when you compile the core v4l2 stuff.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
