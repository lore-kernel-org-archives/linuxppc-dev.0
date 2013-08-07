Return-Path: <tony.luck@gmail.com>
Received: from mail-ve0-x236.google.com (mail-ve0-x236.google.com
 [IPv6:2607:f8b0:400c:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABBB52C00F6
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 13:25:58 +1000 (EST)
Received: by mail-ve0-f182.google.com with SMTP id m1so1218592ves.41
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Aug 2013 20:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5201A9BD.4090503@linux.vnet.ibm.com>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
 <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
 <51FFDC8B.7010909@linux.vnet.ibm.com>
 <CA+8MBb+1LpR+Cx=84WZT98U5eqZcm1KriUP75aCg+uSrXrb3Yw@mail.gmail.com>
 <51FFFFEB.3030907@linux.vnet.ibm.com>
 <CA+8MBbK9oZJO+RJGC-7riO=Kz=UbRcAvQ-nDi=2GLyvEDpoc7g@mail.gmail.com>
 <CA+8MBbKA+P4vs3utSKQ-LPMW3ybrWOp=f3FH6ahv1YtwnMm5KA@mail.gmail.com>
 <5201A9BD.4090503@linux.vnet.ibm.com>
Date: Tue, 6 Aug 2013 20:25:55 -0700
Message-ID: <CA+8MBbJS0Dymn4OABi-rW9M5Bw-ZZ6DaEjQOW-oki+4ge4BDtg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
From: Tony Luck <tony.luck@gmail.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 6, 2013 at 6:58 PM, Aruna Balakrishnaiah
<aruna@linux.vnet.ibm.com> wrote:
> The patch looks right. I will clean it up. Does the issue still persist
> after this?

Things seem to be working - but testing has hardly been extensive (just
a couple of forced panics).

I do have one other question. In this code:

>>                  if (compressed && (type == PSTORE_TYPE_DMESG)) {
>>                          big_buf_sz = (psinfo->bufsize * 100) / 45;

Where does the magic multiply by 1.45 come from?  Is that always enough
for the decompression of "dmesg" type data to succeed?

-Tony
