From: kd@flaga.is
Subject: Re: compiling glibc
To: "Michael A. Peters" <mpeters@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFD758151F.625FC112-ON002568AF.0041E002@flaga.is>
Date: Mon, 27 Mar 2000 12:01:18 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is a patch floating on the linuxppc-dev or linuxppc-embedded mailing
list that fixes this.

You can also fix it your self. There is one comma (,) and one semicolon (;)
missing in the C-ctype.c file.

K.D.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
