Date: Fri, 9 Jun 2000 11:25:12 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Alain Birtz <abz@videotron.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: get_user, put_user and asm/uaccess.h problem
In-Reply-To: <39402154.1D8190E4@videotron.ca>
Message-ID: <Pine.LNX.4.10.10006091124530.10857-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I need to use get_user and put_user in a small module. These functions
> are defined in asm/uaccess.h
> But #include asm/uaccess.h generate a lot of error (about 3 page).
> How can I fix it ?

-D__KERNEL__ ??

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
