Return-Path: <babu.pci81@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 3B528DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:23:59 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so269307rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 22:23:57 -0700 (PDT)
Message-ID: <a38e30640709122223m60913ad5xf3c95e636e3b3350@mail.gmail.com>
Date: Thu, 13 Sep 2007 10:53:57 +0530
From: "lakshminarayana babu" <babu.pci81@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84
In-Reply-To: <20070913044011.GA7706@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7244_17520494.1189661037686"
References: <mailman.2011.1189652741.2970.linuxppc-dev@ozlabs.org>
	<a38e30640709122131g14642e9pa599681551ed9c23@mail.gmail.com>
	<20070913044011.GA7706@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7244_17520494.1189661037686
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sir,
   can you plese suggest any book for pci driver writing...At present i am
studying linux device drivers by alexandrorubini

On 9/13/07, Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Sep 13, 2007 at 10:01:36AM +0530, lakshminarayana babu wrote:
> > i am new to the linux.....can you tell me how to access the pci
> > configuration space using ioremap function...but  it is implicit
> function
> > declaration...
>
> That is architecture and platform dependent. Some platforms don't even
> have a memory-mappable interface to configuration space.
>
> Instead, please use the abstracted config access functions that the
> kernel provides. (pci_read_config_word and friends).
>
>
> -Olof
>

------=_Part_7244_17520494.1189661037686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sir,<br>&nbsp;&nbsp; can you plese suggest any book for pci driver writing...At present i am studying linux device drivers by alexandrorubini<br><br><div><span class="gmail_quote">On 9/13/07, <b class="gmail_sendername">Olof Johansson
</b> &lt;<a href="mailto:olof@lixom.net">olof@lixom.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Thu, Sep 13, 2007 at 10:01:36AM +0530, lakshminarayana babu wrote:
<br>&gt; i am new to the linux.....can you tell me how to access the pci<br>&gt; configuration space using ioremap function...but&nbsp;&nbsp;it is implicit function<br>&gt; declaration...<br><br>That is architecture and platform dependent. Some platforms don&#39;t even
<br>have a memory-mappable interface to configuration space.<br><br>Instead, please use the abstracted config access functions that the<br>kernel provides. (pci_read_config_word and friends).<br><br><br>-Olof<br></blockquote>
</div><br>

------=_Part_7244_17520494.1189661037686--
