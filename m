Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: gopi@tejasnetworks.com
Date: Thu, 15 Mar 2001 18:26:43 +0530 (IST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Accessing file from drivers
Message-ID: <Pine.LNX.4.21.0103151822090.9108-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi..

  Is it possible to read and write to files (say /etc/xyz)
in a device driver without resorting to user space?  I want
to read the config info stored in a file and program few
devices according to that.

fops->read method does a copy to the user space, so I guess, getting
filp with a filp_open and then filp->fops->read wouldn't help.

gopi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
