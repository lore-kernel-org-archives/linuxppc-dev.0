From: Benjamin Herrenschmidt <benh@mipsys.com>
To: <galak@ibmoto.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re; 2.4.0-test9 on B&W G3 
Date: Fri, 22 Sep 2000 18:47:05 +0200
Message-Id: <20000922164705.32547@mail.mipsys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

>I have also been seeing the same old 'lost interrupt' problem when trying
>to boot a B&W G3 using the latest yaboot (0.8) on the latest pmac-devel
>rsync kernel.  I was wondering if this was a know bug with the latest 2.4
>tree kernel's.  I also booted the same kernel on a new G4/450 with no
>problems.

I have a fix for that too. I'll push it as soon as I have access to bk again.
In the meantime, apply enclosed changeset to the current linuxppc_2_3 bk tree.

This changeset revives Geert PCI code, adds Samuel fix (indeed the
correct fix), and
add some more IDE fix for PCI-IDE controllers like the CMD646.

Ben.

--==_Boundary-1_==
Content-Type: application/octet-stream; name="pci_ide_fix.cset.bz2";
 x-mac-type="203E2074"; x-mac-creator="6F207265"
Content-Disposition: attachment
Content-Transfer-Encoding: base64

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
--==_Boundary-1_==--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
