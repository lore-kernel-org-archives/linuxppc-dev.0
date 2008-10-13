Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id A2BA1DDFB3
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 00:40:01 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so460105qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 06:40:00 -0700 (PDT)
Message-ID: <c384c5ea0810130640w7d0031f5j130c4edf83acccaf@mail.gmail.com>
Date: Mon, 13 Oct 2008 15:40:00 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Bill Gatliff" <bgat@billgatliff.com>
Subject: Re: Floating inputs on unused GPIO pins
In-Reply-To: <48F34922.503@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200810131156.59477.laurentp@cse-semaphore.com>
	<c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
	<200810131304.41435.laurentp@cse-semaphore.com>
	<48F34922.503@billgatliff.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Laurent,

On Mon, Oct 13, 2008 at 3:12 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> At least until someone plugs in that expansion module!
>
Bill's remark made a neuron connection in my head:

Can you detect if the module is inserted or not? (By reading a known
state of some pin)?

You could then configure the pins dynamically in your driver.

Regards,
-- 
Leon
