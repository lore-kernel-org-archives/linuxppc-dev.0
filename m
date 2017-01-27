Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8fWL5xPPzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:17:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 11:17:47 +1100
Message-ID: <87sho58ifo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:

> Added check for OPAL_WRONG_STATE error code returned from OPAL.
> Currently Linux flashes "unexpected error" over console for this
> error. This will avoid throwing such message and return I/O error
> for such OPAL failures.

Why do we expect to get OPAL_WRONG_STATE ?

cheers
