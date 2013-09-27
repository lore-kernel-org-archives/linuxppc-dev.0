Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9F562C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 07:54:06 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id ar20so5242400iec.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 14:54:03 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1380318405.27811.37.camel@pasglop>
References: <1380270519.27811.10.camel@pasglop>
 <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
 <CA+55aFyDfMdAeaniQwkoeW6F-xd3JxrzGYwtFb6N9+NA6aRCMg@mail.gmail.com>
 <1380318405.27811.37.camel@pasglop>
Date: Fri, 27 Sep 2013 14:54:02 -0700
Message-ID: <CAE9FiQXXvkfTak6oEpUog_RYs_Gwpdji7N5UJ=R11Q61==N97A@mail.gmail.com>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=089e0149c10c4e0b6604e76486c7
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e0149c10c4e0b6604e76486c7
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Sep 27, 2013 at 2:46 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Wouldn't it be better to simply have pci_enable_device() always set bus
> master on a bridge? I don't see any case where it makes sense to have
> an enabled bridge without the master bit set on it...

Do you mean attached?

--089e0149c10c4e0b6604e76486c7
Content-Type: application/octet-stream; name="pci_set_master_again.patch"
Content-Disposition: attachment; filename="pci_set_master_again.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hm3y6pzm0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMKaW5kZXgg
ZThjY2Y2Yy4uNGVmZjk5YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKKysrIGIvZHJp
dmVycy9wY2kvcGNpLmMKQEAgLTExNTYsMTEgKzExNTYsMTMgQEAgc3RhdGljIHZvaWQgcGNpX2Vu
YWJsZV9icmlkZ2Uoc3RydWN0IHBjaV9kZXYgKmRldikKIAlwY2lfZW5hYmxlX2JyaWRnZShkZXYt
PmJ1cy0+c2VsZik7CiAKIAlpZiAocGNpX2lzX2VuYWJsZWQoZGV2KSkKLQkJcmV0dXJuOworCQln
b3RvIG91dDsgLyogc29tZSBvdGhlciBkcml2ZXIgY291bGQgc2tpcCBwY2lfc2V0X21hc3RlciAh
ICovCiAJcmV0dmFsID0gcGNpX2VuYWJsZV9kZXZpY2UoZGV2KTsKIAlpZiAocmV0dmFsKQogCQlk
ZXZfZXJyKCZkZXYtPmRldiwgIkVycm9yIGVuYWJsaW5nIGJyaWRnZSAoJWQpLCBjb250aW51aW5n
XG4iLAogCQkJcmV0dmFsKTsKKworb3V0OgogCXBjaV9zZXRfbWFzdGVyKGRldik7CiB9CiAK
--089e0149c10c4e0b6604e76486c7--
