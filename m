Message-Id: <200309020913.EAA17470@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: DINK32 R13.1 on Sandpoint X2 
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 2 Sep 2003 17:22:8 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all,
    Now I'm working on a Motorola Sandpoint X2 board with ppc8240.
I use DINK32 r13.1 to boot my linux kernel image.
    From DINK32 r13.1 user manual,I know that DINK32 r13.1 supports
ethernet card Realtek 8139,but after these steps:
       DINK32[MPC8240] {7} >>ni -i
        some configrations......

       DINK32[MPC7455] {8} >>ni
       NETWORK INFORMATION
            PCI CARD
            Type 8139/10EC on slot 16
            SETTINGS
            SERVER(TFTP) : 10. 18.15.27
            GATEWAY : 10. 18.15.254
            NETMASK : 255.255.255. 0
            DHCP : 0. 0. 0. 0
            CLIENT(DINK) : 10. 18.15.201
            DHCP: Disabled
            SESSION TIMEOUT: Never

 Then I reset the system,but the Tealtek 8139 seems not to work correctly!:(
 I ping the board from my host computer with OS Redhat linux 9.0,but I can't
 get any response!
 Can anyone help me?

　　　　　　　　Yuxiao Xi
　　　　　　　　xiyuxiao@harbournetworks.com
　　　　　　　　　　2003-09-02

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
