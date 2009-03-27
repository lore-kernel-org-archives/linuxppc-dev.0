Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 2889EDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 02:57:27 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so643819ywe.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 08:57:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49CCDFBD.6020602@monstr.eu>
References: <49CCDFBD.6020602@monstr.eu>
Date: Fri, 27 Mar 2009 09:57:25 -0600
Message-ID: <fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com>
Subject: Re: DTC sources move
From: Grant Likely <grant.likely@secretlab.ca>
To: monstr@monstr.eu
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 8:16 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi Ben,
>
> could you please move DTC to any generic location. I would like to use it for Microblaze cpu too.

Michal,

David Gibson is the one responsible for the in-tree dtc source, not
Ben, and you should prepare the patches yourself to move dtc.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
