Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000701c1001f$7d475ea0$9696143e@jocke>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc860 with dual ethernets
Date: Fri, 29 Jun 2001 00:12:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I need 2 Ethernet network i/f's(SCC1 and SCC2). Looking into
enet.c is seems that this driver can only support one Ethernet SCC
at a time. Is there a version of enet.c that can support both
SCC1 and SCC2 simultaneously?

    Joakim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
