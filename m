Message-ID: <20000215143917.12321.qmail@web215.mail.yahoo.com>
Date: Tue, 15 Feb 2000 06:39:16 -0800 (PST)
From: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Subject: Problem creating symbol file...
To: embedded linuxppc <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've strip the header of zvmlinux.inird
Convert the file to S-record format
Convert the S-record file into .BIN with the convert
program of VisionClick (EST).
And dowloading the file into the FLASH at 0x8000000
That's ok.

Now I want ot create the symbol file to view in
source.
But when I want to extract symbol file from
zvmlinux.initrd I obtain this:

.id "conversion date" "Feb 15 2000  10:46:27"
.id CONVERT  "7.2C"
.id "options" C:\test_cube\Linux\zvmlinux.initrd -c
C:\test_cube\Linux\elfzvm.ab -m gnu -z
.defg {start_} #100004
.defg {start_ldr} #100008
.defg {hang} #100114
.defg {inflate_blocks_reset} #101754
.defg {inflate_blocks_free} #102710
.defg {inflate_blocks_new} #101838
.defg {inflate_blocks} #10190C
.defg {inflate_packet_flush} #102900
.defg {inflate_addhistory} #102790
.defg {inflate_mask} #106000
.defg {border} #106044
.defg {inflate_codes_free} #103D94
.defg {inflate_trees_free} #1033C0
.defg {inflate_trees_fixed} #103188
.defg {inflate_codes_new} #103430
.defg {inflate_flush} #103DCC
.defg {inflate_trees_bits} #102F64
.defg {inflate_trees_dynamic} #102FF4
.defg {inflate_codes} #1034B4
.defg {cplens} #106090
.defg {cplext} #10610C
.defg {cpdist} #106188
.defg {cpdext} #106200
.defg {huft_build} #102924
.defg {fixed_lock} #1062C4
.defg {fixed_built} #1062C8
.defg {fixed_left} #1062CC
.defg {falloc} #103160
.defg {fixed_mem} #107014
.defg {ffree} #103184
.defg {fixed_bl} #1062D4
.defg {fixed_tl} #1062DC
.defg {fixed_bd} #1062D8
.defg {fixed_td} #1062E0
.defg {inflate_fast} #103F94
.defg {cpmp} #1062E4
.defg {avail_ram} #107000
.defg {qs_pci_write_config_dword} #1050D0
.defg {inb} #100F00
.defg {pci_map} #112BB0
.defg {pause} #100174
.defg {__pmac_end} #107000
.defg {gunzip} #1003A4
.defg {qs_pci_read_config_byte} #104D34
.defg {nfsaddrs_string} #1062A0
.defg {__prep_end} #107000
.defg {probe_addresses} #104944
.defg {sanity} #10A0A4
.defg {qs_pci_write_config_word} #104FE4
.defg {_etext} #10515C
.defg {do_ipaddrs} #100AA8
.defg {inflate} #101178
.defg {inflateInit2} #101048
.defg {_get_MSR} #100164
.defg {getc} #1001D8
.defg {memcpy} #10028C
.defg {puts} #100228
.defg {zimage_start} #107004
.defg {puthex} #100E94
.defg {edata} #1062F8
.defg {hold_resid_buf} #10C0A4
.defg {nfsroot_string} #1062A4
.defg {decompress_kernel} #100574
.defg {cmd_line} #106298
.defg {map_pci_addrs} #104A74
.defg {defroot_string} #1062A8
.defg {inflateIncomp} #1015A0
.defg {strrchr} #100E30
.defg {initrd_start} #1062B4
.defg {tstc} #1001B8
.defg {zlib_version} #1062D0
.defg {adler32} #104378
.defg {serial_putchar} #1046B0
.defg {zfree} #1003A0
.defg {zimage_size} #107008
.defg {end} #112F30
.defg {serial_tstc} #104740
.defg {pci_scanner} #104760
.defg {initrd_end} #1062B8
.defg {do_nfsroot} #100CC8
.defg {__init_begin} #107000
.defg {_SDA_BASE_} #10E298
.defg {hold_residual} #1062B0
.defg {strncmp} #100DEC
.defg {udelay} #100118
.defg {inflateReset} #100F48
.defg {memcmp} #1002B8
.defg {__init_end} #107000
.defg {_put_MSR} #10016C
.defg {inflateSync} #1015E0
.defg {qs_pci_read_config_dword} #104E74
.defg {ramroot_string} #1062AC
.defg {outb} #100EEC
.defg {__stop___ex_table} #106310
.defg {_bcopy} #100F1C
.defg {__bss_start} #107000
.defg {__pmac_begin} #107000
.defg {ISA_mem} #1062C0
.defg {cmd_buf} #112AB0
.defg {__openfirmware_begin} #107000
.defg {putc} #100204
.defg {root_string} #10629C
.defg {serial_init} #104504
.defg {z_errmsg} #106278
.defg {__openfirmware_end} #107000
.defg {error} #1002FC
.defg {qs_pci_read_config_word} #104DD4
.defg {__start___ex_table} #1062F8
.defg {_edata} #1062F8
.defg {_GLOBAL_OFFSET_TABLE_} #1062EC
.defg {_end} #112F30
.defg {zalloc} #10033C
.defg {ISA_io} #1062BC
.defg {.stack} #1080A4
.defg {exit} #10019C
.defg {serial_getc} #1046FC
.defg {__prep_begin} #107000
.defg {start} #100000
.defg {local_to_PCI} #100F14
.defg {strlen} #100DC8
.defg {inflateInit} #101154
.defg {qspan_init} #104CD8
.defg {pci_dev_cnt} #107010
.defg {inflateEnd} #100FC0
.defg {qs_pci_write_config_byte} #104EF8
.defg {_SDA2_BASE_} #10E2E8
.defg {end_avail} #10700C
.start #100000
.dcl 2 {UNKNOWN TYPE} t 0
.dcl 4 {void} t 0
.dcl 6 {signed char} t 1 s s
.dcl 8 {unsigned char} t 1 s c
.dcl 10 {signed short int} t 2 s i
.dcl 12 {unsigned short int} t 2 s u
.dcl 14 {signed long} t 4 s l
.dcl 16 {unsigned long} t 4 s w
.dcl 18 {signed long long} t 8 s l
.dcl 20 {unsigned long long} t 8 s w
.dcl 22 {float} t 4 s f
.dcl 24 {double} t 8 s d
.dcl 26 {long double} t 12 s d
.dcl 28 {long long double} t 16 s d
.dcl 30 {QUOTED STRING} t 0
.dcl 32 {instruction address} t 4
.dcl 34 {int} t 4 s i
.dcl 36 {unsigned} t 4 s u
.dcl 38 {unsigned int} t 4 s u
.dcl 40 {char} t 1 s s
.dcl 42 {long} t 4 s l
.dcl 44 {short} t 2 s i
.dcl 46 {unsigned short} t 2 s u
.dcl 48 {short int} t 2 s i
.dcl 50 {signed short} t 2 s i
.dcl 52 {BCD float} t 8
.dcl 54 {bool} t 1
.dcl 1 {UNKNOWN TYPE *} t 4 p 2
.dcl 3 {void *} t 4 p 4
.dcl 5 {signed char *} t 4 p 6
.dcl 7 {unsigned char *} t 4 p 8
.dcl 9 {signed short int *} t 4 p 10
.dcl 11 {unsigned short int *} t 4 p 12
.dcl 13 {signed long *} t 4 p 14
.dcl 15 {unsigned long *} t 4 p 16
.dcl 17 {signed long long *} t 4 p 18
.dcl 19 {unsigned long long *} t 4 p 20
.dcl 21 {float *} t 4 p 22
.dcl 23 {double *} t 4 p 24
.dcl 25 {long double *} t 4 p 26
.dcl 27 {long long double *} t 4 p 28
.dcl 29 {QUOTED STRING *} t 4 p 30
.dcl 31 {instruction address *} t 4 p 32
.dcl 33 {int *} t 4 p 34
.dcl 35 {unsigned *} t 4 p 36
.dcl 37 {unsigned int *} t 4 p 38
.dcl 39 {char *} t 4 p 40
.dcl 41 {long *} t 4 p 42
.dcl 43 {short *} t 4 p 44
.dcl 45 {unsigned short *} t 4 p 46
.dcl 47 {short int *} t 4 p 48
.dcl 49 {signed short *} t 4 p 50
.dcl 51 {BCD float *} t 4 p 52
.dcl 53 {bool *} t 4 p 54

That's all...

How do you create your symbol file?

Is symbol table located in the first 64K of
zvmlinux.initrd?

Thanks you

Sebastien ARTICLAUX


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
