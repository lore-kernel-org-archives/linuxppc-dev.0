Return-Path: <prashant.alange@gmail.com>
Message-ID: <6d145b42050728112919ab22b@mail.gmail.com>
Date: Thu, 28 Jul 2005 11:29:54 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <5367eda3a78096bb46168292371e9530@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6d145b4205072809505b101b48@mail.gmail.com>
	<5367eda3a78096bb46168292371e9530@embeddededge.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problem allocating large meory using m8260_cpm_hostalloc
Reply-To: Prashant Alange <prashant.alange@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Could you pls tell me what function I should be using for larger
memories. I do not know much about the memory management in linux.  It
would be heleful if you can throw some light on this in terms of
functions I should use. I could not find the file DMA-API.txt file but
I did get DMA-mapping.txt. Is this the file you were referring to?

Thanks,
Prashant


On 7/28/05, Dan Malek <dan@embeddededge.com> wrote:
>=20
> On Jul 28, 2005, at 12:50 PM, Prashant Alange wrote:
>=20
> > Could anyone tell what I am missing here?
>=20
> You are not supposed to be using this function for such memory
> allocations.
>=20
> > How can I allocate large memory in my driver using this hostalloc
> > function?
>=20
> You don't.  If you look at the existing drivers and comments, you'll
> see it's
> intended to only allocate small objects that are too inefficient to
> manage
> with the usual Linux DMA allocation functions.  You must use the
> standard
> Linux DMA for large allocations.  Read Documentation/DMA-API.txt, and
> in particular the non-PCI functions.
>=20
> Thanks.
>=20
>=20
>        -- Dan
>=20
>
