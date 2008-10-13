Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id D142CDDEF7
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 21:08:18 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so436631qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 03:08:17 -0700 (PDT)
Message-ID: <c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
Date: Mon, 13 Oct 2008 12:08:17 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: Floating inputs on unused GPIO pins
In-Reply-To: <200810131156.59477.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200810131156.59477.laurentp@cse-semaphore.com>
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

On Mon, Oct 13, 2008 at 11:56 AM, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
> our hardware engineer asked me to make sure all unused GPIO pins are configured as outputs to avoid floating inputs. He got theory on his side (floating inputs can lead to higher current consumption, metastability or even permanent damage), but I'd like to ask the list for practical feedback.
>
Ideally, configure them as inputs or tri-state (both mean high
impedance), and do use pull-down or -up resistors.

Now, the answer might be different when your pins are not connected.
Check on the processor if internal pull resistors are present. If so,
use as input. If not, then your h/w engineer *may* have a point, not
sure on that though.

Regards,
-- 
Leon
