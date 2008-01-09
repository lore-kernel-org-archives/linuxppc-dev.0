Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.245])
	by ozlabs.org (Postfix) with ESMTP id D7CF9DDF20
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:46:10 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so211359agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:46:09 -0800 (PST)
Message-ID: <fa686aa40801090746k4ec5c208j9daf224cb2570071@mail.gmail.com>
Date: Wed, 9 Jan 2008 08:46:08 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <4784E78C.40904@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Matt Sealey <matt@genesi-usa.com> wrote:
> Please let's keep the nature of our firmware and the Linux codebase
> independant, and move the burden of support to Genesi, and not the
> Linux PowerPC team. After all, what is next, after phy-handle do
> you want to add i2c, irda, missing xlb/cdm entries in the patch so
> that other things work? Does everyone have to custom compile their
> own kernel? What happens if we do another firmware release and
> the Linux kernel overwrites important values without checking as
> it does now? It simply causes problems.

FWIW, I've got a patch in my tree that removes a bunch of the efika
fixups.  I've learned a lot over the past year and I'm taking a more
pragmatic approach.  So, fixups that are not absolutely required to
get a working Efika are going away.

However, I'm still inclined to pick up Olaf's patch with the
appropriate protections around it so it is only done if the nodes are
missing.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
