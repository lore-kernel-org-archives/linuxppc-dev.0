Message-Id: <20010630092151.Postino-012521@smtp01.highway.ne.jp>
Date: Sat, 30 Jun 2001 09:21:51 +0900
To: linuxppc-dev@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: problem in kernel-2.4.6.pre6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I have had compilation problem in kernel-2.4.6.pre6-devel also standard.
The error is

usb-ohci.c: Infunction 'ohci_sleep_notify'
usb-ohci.c:2752 too few argments to function 'ohci_pci_supend'


ochi_pci_suspend (strct pci_dev *dev, u32 state){
<snip>
}

static int ohci_sleep_notify(struct pmu_sleep_notifier * self, int when){
<snip>
                  case PBOOK_SLEEP_NOW:
                       ohci_pci_suspend(ohci->ohci_dev); <--- it's worng
<snip>

}

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
