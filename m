Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.231])
	by ozlabs.org (Postfix) with ESMTP id 7B84ADDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 23:17:11 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so2100285qbe
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:17:09 -0700 (PDT)
Message-ID: <fa686aa40710160617o57564cb4r260a40cd66407852@mail.gmail.com>
Date: Tue, 16 Oct 2007 07:17:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Merge dtc
In-Reply-To: <20071016050217.GA9052@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071016050217.GA9052@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> This very large patch incorporates a copy of dtc into the kernel
> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> longer an external dependency to build kernels with configurations
> which need a dtb file.

Powerpc is probably not going to be the only user of dtc.  Microblaze
will be using it too.  Can it be put somewhere more common?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
