Return-Path: <purushtm1@gmail.com>
MIME-Version: 1.0
Date: Tue, 26 May 2009 14:59:07 +0530
Message-ID: <8730448c0905260229r21ea29adt3e2813c38c68f617@mail.gmail.com>
Subject: Query on KGDBOE
From: purushothama s <purushtm1@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd23e7cc9fc24046acd5b56
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd23e7cc9fc24046acd5b56
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All,

I am working on Xilinx virtex5 ppc44x target. I am seeing that
CONFIG_NET_POLL_CONTROLLER is not present xlltemac_main.c, has anybody come
across it.  And I also see lltemac is working in interrupt driven mode and
not in polled mode. Is it possible support KGDBOE for xilinx LLTEMAC driver
from Xilinx Git:

log of kernel crash:
===============
KGDB: re-enter exception: ALL breakpoints killed
 Call Trace:
 [c0391a10] [c00060d0] show_stack+0x4c/0x16c (unreliable)
 [c0391a50] [c0067b54] kgdb_handle_exception+0xb28/0xe14
[c0391af0] [c000fa50] kgdb_handle_breakpoint+0x4c/0x8c
 [c0391b00] [c000ce40] program_check_exception+0x45c/0x600
 [c0391b20] [c000f090] ret_from_except_full+0x0/0x4c
 [c0391be0] [c0390000] 0xc0390000
[c0391bf0] [c01df520] xenet_DmaSend+0x48/0x60
 [c0391c10] [c023001c] netpoll_send_skb+0x174/0x1c0
 [c0391c50] [c01e45a8] eth_flush_buf+0x44/0x80
[c0391c70] [c0067394] kgdb_handle_exception+0x368/0xe14
 [c0391d10] [c000fa50] kgdb_handle_breakpoint+0x4c/0x8c
 [c0391d20] [c000ce40] program_check_exception+0x45c/0x600
 [c0391d40] [c000f090] ret_from_except_full+0x0/0x4c
[c0391e00] [c0390000] 0xc0390000
 [c0391e10] [c003bb0c] tasklet_action+0xa0/0x1d0
 [c0391e40] [c003bce8] __do_softirq+0xac/0x1d4
[c0391e80] [c0003ef4] do_softirq+0x5c/0x60
 [c0391e90] [c003b820] irq_exit+0xc0/0xc4
 [c0391ea0] [c00043f0] do_IRQ+0xa0/0xc4
 [c0391ec0] [c000f0dc] ret_from_except+0x0/0x18
 [c0391f80] [c000725c] cpu_idle+0x50/0xf0
** [c0391fa0] [c02a95b0] __got2_end+0x80/0x94
 [c0391fc0] [c03427f8] start_kernel+0x230/0x2ac
 [c0391ff0] [c0000218] skpinv+0x1a8/0x1e4
 Kernel panic - not syncing: Recursive entry to debugger

Thanks and Regards
Purushothama.S

--000e0cd23e7cc9fc24046acd5b56
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font size=3D"3">Hi All,<br>
<br>
I am working on Xilinx virtex5 ppc44x target. I am seeing that
CONFIG_NET_POLL_CONTROLLER is not present xlltemac_main.c, has anybody
come across it.=A0 And I also see lltemac is working in interrupt
driven mode and not in polled mode. Is it possible support KGDBOE for
xilinx LLTEMAC driver from Xilinx Git:<br>
<br>
log of kernel crash:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
</font><font size=3D"3">KGDB: re-enter exception: ALL breakpoints killed</f=
ont><br>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> Ca=
ll Trace:                                                         </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391a10] [c00060d0] show_stack+0x4c/0x16c (unreliable)            </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391a50] [c0067b54] kgdb_handle_exception+0xb28/0xe14             </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3">[c0=
391af0] [c000fa50] kgdb_handle_breakpoint+0x4c/0x8c              </font><br=
>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391b00] [c000ce40] program_check_exception+0x45c/0x600           </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391b20] [c000f090] ret_from_except_full+0x0/0x4c                 </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391be0] [c0390000] 0xc0390000                                    </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3">[c0=
391bf0] [c01df520] xenet_DmaSend+0x48/0x60                       </font><br=
>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391c10] [c023001c] netpoll_send_skb+0x174/0x1c0                  </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391c50] [c01e45a8] eth_flush_buf+0x44/0x80                       </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3">[c0=
391c70] [c0067394] kgdb_handle_exception+0x368/0xe14             </font><br=
>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391d10] [c000fa50] kgdb_handle_breakpoint+0x4c/0x8c              </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391d20] [c000ce40] program_check_exception+0x45c/0x600           </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391d40] [c000f090] ret_from_except_full+0x0/0x4c                 </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3">[c0=
391e00] [c0390000] 0xc0390000                                    </font><br=
>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391e10] [c003bb0c] tasklet_action+0xa0/0x1d0                     </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391e40] [c003bce8] __do_softirq+0xac/0x1d4                       </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3">[c0=
391e80] [c0003ef4] do_softirq+0x5c/0x60                          </font><br=
>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391e90] [c003b820] irq_exit+0xc0/0xc4                            </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391ea0] [c00043f0] do_IRQ+0xa0/0xc4                              </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391ec0] [c000f0dc] ret_from_except+0x0/0x18                      </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391f80] [c000725c] cpu_idle+0x50/0xf0                            </font><b=
r>
<font color=3D"#a82f2f"><b><font size=3D"3"></font></b></font><font size=3D=
"3"> [c0391fa0] [c02a95b0] __got2_end+0x80/0x94                          </=
font><br>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391fc0] [c03427f8] start_kernel+0x230/0x2ac                      </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> [c=
0391ff0] [c0000218] skpinv+0x1a8/0x1e4                            </font><b=
r>
<font size=3D"2"><font color=3D"#a82f2f"></font></font><font size=3D"3"> Ke=
rnel panic - not syncing: Recursive entry to debugger<br>
<br>
Thanks and Regards<br>
Purushothama.S<br>
  </font>

--000e0cd23e7cc9fc24046acd5b56--
