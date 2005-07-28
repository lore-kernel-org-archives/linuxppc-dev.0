Return-Path: <prashant.alange@gmail.com>
Message-ID: <6d145b420507281055ce199f9@mail.gmail.com>
Date: Thu, 28 Jul 2005 10:55:00 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: "Goodman, Brad" <bgoodman@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901011B00CC@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BD261180E6D35F4D9D32F3E44FD3D901011B00CC@EMPBEDEX.empirix.com>
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

Thanks I saw linux/mmzone.h file. MAX_ORDER depends on the
CONFIG_FORCE_MAX_ZONEORDER macro. But I do not see any option in
menuconfig to change this value. I am using 2.4.22 kernel on MPC8260
kernel. Can you pls tell me how to chaneg this?

Thanks,
Prashant
I do not see any option in menuconfig to change this value.

On 7/28/05, Goodman, Brad <bgoodman@empirix.com> wrote:
> I think you have to increase MAX_ORDER in linux/mmzone.h
>=20
> This number means you can allocate a maximum of 2^(MAX_ORDER-1)
> contiguous pages.
>=20
> Brad Goodman
>=20
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Prashant
> Alange
> Sent: Thursday, July 28, 2005 12:50 PM
> To: Linuxppc-embedded@ozlabs.org
> Subject: Problem allocating large meory using m8260_cpm_hostalloc
>=20
> Hi everyone,
> I am having problem in allocating large memory using
> m8260_cpm_hostalloc function in my driver. (Approx 256 Kbytes). I
> tried increaing the NUM_CPM_HOST_PAGES macro in cpm_8260.h file to 64
> but still it fails for 200K of memory request. This macro is used by
> alloc_bootmem_pages() function. I have read that we should use this
> function if we intend to have consecutive memory pages allocated.
>=20
> Could anyone tell what I am missing here?
> How can I allocate large memory in my driver using this hostalloc
> function?
>=20
> Thanks for your time.
>=20
> Prashant
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
