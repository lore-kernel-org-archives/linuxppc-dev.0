Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: eieio rule-of-thumb?
Date: Tue, 21 May 2002 21:43:37 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEGJDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was wondering if anyone had a rule for the use of eieio or sync
instructions? After reviewing some of the newer code, it appears that eieio
is used fairly often (at least in some code), sync is hardly ever used. Is a
consideration for use whether data is being manipulated on different buses?
(that would be my assumption) I would assume that operations on the same bus
would occur in the proper sequence.

TIA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
