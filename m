Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 9670F67B97
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 12:05:51 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so569688nfe
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Sep 2006 19:05:50 -0700 (PDT)
Message-ID: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:05:49 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
Subject: powerpc power management
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I need to implement suspend to ram (sleep mode) on an embedded powerpc
processor.  I have googled generally and searched the lkml, this list
and the linux power management mailing list.  It seems after all this
searching that the only existing code is for the powermac in
drivers/macintosh/(variousfiles) and
arch/powerpc/platforms/powermac/(variousfiles).  Is this true or am I
missing something?

Thanks
John
