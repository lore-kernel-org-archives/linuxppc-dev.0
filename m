Message-ID: <3D63CBDC.9010807@dslextreme.com>
Date: Wed, 21 Aug 2002 10:20:28 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Restructuring of ibm_ocp_enet driver
References: <20020821043627.GF18818@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> The patch below make some first steps to restructuring the
> ibm_ocp_enet driver to separate drivers for the EMAC and MAL
> components.  This is necessary to sanely allocate the various IRQs.
> It will also be necessary to sanely incorporate the driver into the
> unified device model.
<snipped>
>
> --
> David Gibson			| For every complex problem there is a


David,

I don't see any probelms with this for 2.5.
I would like to see these changes done for *devel and it should just
easely drop in since I didn't see anything UDM specific.  I would like
to keep  delta between 2.4 and 2.5 to a minimum if at all possible. :)
Devel will benefit from this patch because if anyone added support for
the HDLC , I would assume it would be done in 2_4_devel and not in 2.5
at this time.

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
