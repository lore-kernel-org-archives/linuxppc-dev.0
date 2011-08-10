Return-Path: <paulus@ozlabs.org>
Date: Wed, 10 Aug 2011 14:42:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 10/10] KVM: PPC: Enable the PAPR CAP for Book3S
Message-ID: <20110810044215.GA5404@drongo>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-11-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312907508-14599-11-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 06:31:48PM +0200, Alexander Graf wrote:

> Now that Book3S PV mode can also run PAPR guests, we can add a PAPR cap and
> enable it for all Book3S targets. Enabling that CAP switches KVM into PAPR
> mode.

Don't we want to enable it only for 64-bit hosts?  Trying to run a
PAPR guest on a 32-bit Book 3S host won't work very well, unless I am
missing something...

Regards,
Paul.
