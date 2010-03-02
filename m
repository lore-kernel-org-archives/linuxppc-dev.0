Return-Path: <stern+4b9b024c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id C8CCBB7D09
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Mar 2010 04:43:34 +1100 (EST)
Date: Tue, 2 Mar 2010 12:43:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
In-Reply-To: <4B8D44A7.7030302@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003021236560.1375-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2 Mar 2010, Albert Herranz wrote:

> > Currently "this URB doesn't require PIO" is always true, but in the 
> > future it won't be.
> > 
> 
> Can this be currently tested?

Not yet, but soon.  You can follow the gory details in this email 
thread:

	http://marc.info/?l=linux-usb&m=126477569707174&w=2

See especially this email:

	http://marc.info/?l=linux-usb&m=126630714002200&w=2

> Should I make provisions for this check now too?

Don't worry about it.  If you structure the code as I described, it 
will be easy to insert the check later on.

Alan Stern
