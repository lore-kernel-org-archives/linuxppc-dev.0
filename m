From: Ruedi.Hofer@ascom.ch
Date: Wed, 13 Sep 2000 12:55:43 +0100 (CED)
Subject: Antwort: Re: no scc_hdlc struct in commproc.h
To: Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0G0T00N8PNOZ2X@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_ZVwQue4sGfcC8Fo1wAS6PA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_ZVwQue4sGfcC8Fo1wAS6PA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Toby

Is this ISDN support public available?

Ruedi





Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de on 13.09.2000 11:21:53
An: jelbert@enerdyne.com @ MailGate
Kopie: linuxppc-embedded@lists.linuxppc.org @ MailGate
Thema: Re: no scc_hdlc struct in commproc.h


Hello Julia,

> I did not find a scc_hdlc structure like scc_enet and scc_uart in
> commproc.h.

I wrote the following one for my project (which is about adding ISDN
functionality for MPC860):

/*********   SCC parameter RAM for HDLC mode   *********/
typedef struct scc_hdlc {
        ushort  scc_rbase;      // Rx Buffer descriptor base address
        ushort  scc_tbase;      // Tx Buffer descriptor base address
        u_char  scc_rfcr;       // Rx function code
        u_char  scc_tfcr;       // Tx function code
        ushort  scc_mrblr;      // Max receive buffer length
        uint    scc_rstate;     // internal
        uint    scc_idp;        // internal
        ushort  scc_rbptr;      // internal
        ushort  scc_ibc;        // internal
        uint    scc_rxtmp;      // internal
        uint    scc_tstate;     // internal
        uint    scc_tdp;        // internal
        ushort  scc_tbptr;      // internal
        ushort  scc_tbc;        // internal
        uint    scc_txtmp;      // internal
        uint    scc_rcrc;       // internal
        uint    scc_tcrc;       // internal
        // here begins HDLC specific part
        uint    scc_res1;       // reserved
        uint    scc_cmask;      // CRC mask
        uint    scc_cpres;      // CRC preset
        ushort  scc_disfc;      // discarded frame counter
        ushort  scc_crcec;      // CRC error counter
        ushort  scc_abtsc;      // abort sequence counter
        ushort  scc_nmarc;      // nonmatching address receive counter
        ushort  scc_retrc;      // frame retransmission counter
        ushort  scc_mflr;       // Max frame length register
        ushort  scc_maxcnt;     // internal
        ushort  scc_rfthr;      // recceived frames threshold
        ushort  scc_rfcnt;      // internal
        ushort  scc_hmask;      // HDLC address mask register
        ushort  scc_haddr1;     // HDLC address register 1
        ushort  scc_haddr2;     // HDLC address register 2
        ushort  scc_haddr3;     // HDLC address register 3
        ushort  scc_haddr4;     // HDLC address register 4
        ushort  scc_tmp;        // internal
        ushort  scc_tmp_mb;     // internal
} scc_hdlc_t;

Ciao - Tobias






--Boundary_(ID_ZVwQue4sGfcC8Fo1wAS6PA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
