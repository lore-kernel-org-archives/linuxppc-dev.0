Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Subject: DMA support for MPC5xxx?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 2 Jun 2004 16:35:32 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF5022732@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone. Newbie question:
Are MPC5200's IDE UDMA and MDMA have support with the latests changes in bestcomm?
As I've read in the list, IDE and DMA were not supported due to bestcomm microcode (http://lists.linuxppc.org/linuxppc-embedded/200403/msg00214.html). Then, there is an announcement about a new API released on april 2004, included in linuxppc_2_4_devel cvs module. Does this solve the IDE DMA problem? I'm trying to use it on linuxppc_2_4_devel but doesn't work and I don't know if it's broken or I'm doing something wrong.
BTW, the target is a Lite5200 board.
Thanks.

Iñigo

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
