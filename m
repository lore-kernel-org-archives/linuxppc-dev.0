Return-Path: <thuth@redhat.com>
Subject: Re: [PATCH] Fix function keys sequence on USB
To: Dinar Valeev <k0da@opensuse.org>, slof@lists.ozlabs.org
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
 <55E5B27A.8020306@redhat.com>
 <CADqALGQ3xnX75XLWkTpSzqVHhWEmULxjCOEee7=jbU2tpnRiPw@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Dinar Valeev <dvaleev@suse.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55E5BF81.8060707@redhat.com>
Date: Tue, 1 Sep 2015 17:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <CADqALGQ3xnX75XLWkTpSzqVHhWEmULxjCOEee7=jbU2tpnRiPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/15 16:48, Dinar Valeev wrote:
> On Tue, Sep 1, 2015 at 4:13 PM, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi!
>>
>> May I ask what's the status of this patch? As far as I can see, it has
>> not been included in the repository yet?
> Hi,
> Uhh.. I forgot about this patch, since I run local copy.
> 
> No the patch is not included. For me it is unclear why keys don't work
> for me, but they do for Alexey and Nikunj.

At least F12 for the boot menu is currently definitely broken - as the
code in "f12-pressed?" in slof/fs/start-up.fs expects other values than
the libusb code currently generates.

Alexey, Nikunj, could you please check whether the boot menu is working
for you when you run QEMU in graphical mode with "-boot menu=on"?

 Thanks,
  Thomas
