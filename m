Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 3/3 v2] s390: use virtio_console for KVM on s390
Date: Mon, 23 Jun 2008 13:04:00 +1000
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806201524.18953.borntraeger@de.ibm.com>
In-Reply-To: <200806201524.18953.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806231304.01109.rusty@rustcorp.com.au>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 June 2008 23:24:18 Christian Borntraeger wrote:
> This patch enables virtio_console as the default console on kvm for
> s390. We currently use the same notify hack as lguest for early
> console output. I will try to address this for lguest and s390 later.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks, applied all three.

Cheers,
Rusty.
