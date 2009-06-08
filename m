Return-Path: <jwboyer@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 6D87EB70C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 03:07:21 +1000 (EST)
Received: by qw-out-1920.google.com with SMTP id 5so1798698qwf.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Jun 2009 10:07:18 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 8 Jun 2009 13:07:14 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: mkimage for ppc
Message-ID: <20090608170714.GG3088@hansolo.jdub.homelinux.org>
References: <4A24F20E.2020508@redhat.com>
	<1244476138.16253.22.camel@slate.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244476138.16253.22.camel@slate.austin.ibm.com>
Cc: u-boot@lists.denx.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 08, 2009 at 10:48:58AM -0500, Hollis Blanchard wrote:
>Sorry, was on vacation. Copying a couple mailing lists...
>
>On Tue, 2009-06-02 at 12:34 +0300, Avi Kivity wrote:
>> I am now doing regular build tests on various platforms (kernel only for 
>> now).
>
>That's great! Much appreciated.
>
>> But ppc wants a mkimage and I don't have one to give it.  Where 
>> can I find it?
>
>mkimage is a tool provided by u-boot
>(http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=summary). IIRC
>people have discussed the need to include a copy in the kernel source in
>the past, but apparently nothing was ever done about it.

The first patch was pushed back on because it didn't solve it for all the
architectures that use mkimage for various builds.  I'd like to get back to
that, but haven't had time yet.

josh
