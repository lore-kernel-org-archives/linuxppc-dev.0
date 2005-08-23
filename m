Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 6F89F68179
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 03:06:36 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so907836nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 10:06:35 -0700 (PDT)
Date: Tue, 23 Aug 2005 11:03:00 -0600
To: linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>
Message-ID: <20050823170300.GA910@siegfried.thelikelysolution.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Grant Likely <glikely@gmail.com>
Subject: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anyone know the origin of xparameter_ml300.h?  The
Xilinx EDK generates an xparameters.h file for each design, but the
structure of the file changes between releases.

I want to know if xparameters_ml300.h is the exact output produced by
EDK or if stuff was changed before it was submitted to the mainline
tree.  (ie. all the stuff under the "linux redefines" comment block)

Also, where can I get the bitstream/systemace file that matches
xparameters_ml300.h?  I've got a custom ml300 image that I'm regression
testing against, but I'd like to also test against some form of 'stock'
image. :)

Thanks,
g.
