Date: Thu, 08 Jun 2000 18:42:29 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: get_user, put_user and asm/uaccess.h problem
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <39402154.1D8190E4@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need to use get_user and put_user in a small module. These functions
are defined in asm/uaccess.h
But #include asm/uaccess.h generate a lot of error (about 3 page).
How can I fix it ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
